class Cask::Artifact::BeforeBlock < Cask::Artifact::Base
  def self.me?(cask)
    cask.artifacts[:before_install].any? ||
      cask.artifacts[:before_uninstall].any?
  end

  def install_phase
    @cask.artifacts[:before_install].each do |block|
      Cask::DSL::BeforeInstall.new(@cask).instance_eval &block
    end
  end

  def uninstall_phase
    @cask.artifacts[:before_uninstall].each do |block|
      Cask::DSL::BeforeUninstall.new(@cask).instance_eval &block
    end
  end
end
