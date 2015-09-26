require 'active_support/core_ext/object/blank'

class User
  def initialize(name, password = nil)
    @name = name
    @password = password
  end

  def create
    can_create? && create_user && create_group
  end

  def destroy
    can_destroy? && delete_user && delete_group
  end

  private

  def can_create?
    @name.present? && @password.present?
  end

  def can_destroy?
    @name.present?
  end

  def create_group
    args = ['--group', '--file', Settings.paths.groups, '--name', @name, '--gid', gid, '--member',
      @name]
    IO.popen([Settings.paths.ftpasswd, *args]) { |ftpasswd| ftpasswd.read }
    $?.success?
  end

  def create_user
    args = ['--passwd', '--file', Settings.paths.users, '--name', @name, '--uid', uid, '--gid',
      gid, '--home', Settings.paths.home, '--shell', '/bin/false', '--stdin']

    IO.popen([Settings.paths.ftpasswd, *args], 'r+') do |ftpasswd|
      ftpasswd.write @password
      ftpasswd.close_write
      ftpasswd.read
    end

    $?.success?
  end

  def delete_group
    args = ['--group', '--file', Settings.paths.groups, '--name', @name, '--delete-group']
    IO.popen([Settings.paths.ftpasswd, *args]) { |ftpasswd| ftpasswd.read }
    $?.success?
  end

  def delete_user
    args = ['--passwd', '--file', Settings.paths.users, '--name', @name, '--delete-user']
    IO.popen([Settings.paths.ftpasswd, *args]) { |ftpasswd| ftpasswd.read }
    $?.success?
  end

  def gid
    uid
  end

  def next_available_uid
    File.readlines(Settings.paths.users).map do |line|
      line.split(':')[2].to_i
    end.max.next.to_s
  end

  def uid
    @uid ||= next_available_uid
  end
end
