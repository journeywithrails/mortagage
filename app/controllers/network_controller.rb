class NetworkController < ApplicationController
  def initialize
    super
    self.subtab_nav = "network"
  end
end
