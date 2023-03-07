class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_toy
    toy.update!(toy_params)
    render json: toy, status: :ok
  end

  def destroy
    toy = find_toy
    toy.destroy
    render json: toy, status: :no_content
  end

  private

  def find_toy
    Toy.find(params[:id])
  end

  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
