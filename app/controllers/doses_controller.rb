class DosesController < ApplicationController
  def new
    @dose = Dose.new
  end


end
