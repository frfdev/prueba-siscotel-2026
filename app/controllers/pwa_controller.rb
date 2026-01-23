class PwaController < ApplicationController
  protect_from_forgery except: [:manifest, :service_worker]

  def manifest
    respond_to do |format|
      format.json { render "pwa/manifest" }
    end
  end

  def service_worker
    respond_to do |format|
      format.js { render "pwa/service_worker" }
    end
  end
end