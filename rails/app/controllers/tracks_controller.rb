# frozen_string_literal: true

class TracksController < ApplicationController
  before_action :set_track, only: %i[info]

  def info
    render json: {
      track: {
        name: @track.name,
        length: @track.length,
        length_unit: @track.length_unit,
        human_readable_length: "#{@track.length} #{@track.length_unit}",
        material: @track.material,
        address: @track.address.as_json
      }
    }
  end

  private

  def set_track
    @track = Track.first
    render json: { error: 'Track not found' }, status: :not_found if @track.nil?
  end
end
