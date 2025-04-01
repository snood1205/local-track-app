# frozen_string_literal: true

class TracksController < ApplicationController
  before_action :set_track, only: %i[info]

  def info
    render json: {
      track: @track.as_json(only: %i[name length length_unit material],
                            methods: %i[human_readable_length],
                            include: { address: { only: %i[street_line1 street_line2 city
                                                           region postal_code country] } })
    }
  end

  private

  def set_track
    @track = Track.first
    render json: { error: 'Track not found' }, status: :not_found if @track.nil?
  end
end
