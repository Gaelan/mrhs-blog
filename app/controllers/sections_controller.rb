class SectionsController < ApplicationController
  before_action :authenticate_user!
  def index
    authorize Section
    @sections = policy_scope Section.all
  end
end
