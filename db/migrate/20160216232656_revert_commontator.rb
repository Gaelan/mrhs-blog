require_relative '20160211022913_install_commontator.commontator.rb'

class RevertCommontator < ActiveRecord::Migration[5.0]
  def change
    revert InstallCommontator
  end
end
