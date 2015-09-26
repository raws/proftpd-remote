class Fixture
  module Helper
    def fixture(name)
      Fixture.new(name).read
    end
  end

  def initialize(name)
    @name = name
  end

  def read
    File.read path
  end

  private

  def path
    File.expand_path "../../fixtures/#{@name}", __FILE__
  end
end
