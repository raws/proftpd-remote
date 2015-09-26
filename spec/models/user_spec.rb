require 'spec_helper'

describe User do
  context '#create' do
    context 'with a blank name' do
      subject { User.new(' ', 's3cr3t').create }
      it { is_expected.to eq(false) }
    end

    context 'without a password' do
      subject { User.new('foo').create }
      it { is_expected.to eq(false) }
    end

    context 'when user creation succeeds' do
      subject { User.new('foo', 's3cr3t').create }

      before do
        allow(File).to receive(:readlines).with('/test/etc/users').and_return(fixture('users').lines)

        ftpasswd_pipe = instance_spy('IO')
        expect(ftpasswd_pipe).to receive(:write).with('s3cr3t')
        expect(ftpasswd_pipe).to receive(:close_write)

        expect(IO).to receive(:popen).with(['/test/bin/ftpasswd', '--passwd', '--file',
          '/test/etc/users', '--name', 'foo', '--uid', '5002', '--gid', '5002', '--home',
          '/test/home/foo', '--shell', '/bin/false', '--stdin'], 'r+').and_yield(ftpasswd_pipe)

        expect(IO).to receive(:popen).with(['/test/bin/ftpasswd', '--group', '--file',
          '/test/etc/groups', '--name', 'foo', '--gid', '5002', '--member', 'foo'])

        stub_successful_child_process_exit_code
      end

      it { is_expected.to eq(true) }
    end
  end

  context '#destroy' do
    context 'with a blank name' do
      subject { User.new(' ').destroy }
      it { is_expected.to eq(false) }
    end

    context 'when user destruction succeeds' do
      subject { User.new('foo').destroy }

      before do
        expect(IO).to receive(:popen).with(['/test/bin/ftpasswd', '--passwd', '--file',
          '/test/etc/users', '--name', 'foo', '--delete-user'])
        expect(IO).to receive(:popen).with(['/test/bin/ftpasswd', '--group', '--file',
          '/test/etc/groups', '--name', 'foo', '--delete-group'])

        stub_successful_child_process_exit_code
      end

      it { is_expected.to eq(true) }
    end
  end

  private

  def stub_successful_child_process_exit_code
    allow_message_expectations_on_nil
    allow($?).to receive(:zero?).and_return(true)
  end
end
