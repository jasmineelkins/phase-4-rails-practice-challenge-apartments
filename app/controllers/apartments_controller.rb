class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  #   GET /apartments
  def index
    apartments = Apartment.all
    render json: apartments
  end

  # GET /apartments/:id
  def show
    apartment = find_apartment
    render json: apartment
  end

  # POST /apartments
  def create
    new_apartment = Apartment.create!(apartment_params)
    render json: new_apartment, status: :created
  end

  # UPDATE /apartments/:id
  def update
    apartment = find_apartment
    apartment.update!(apartment_params)
    render json: apartment
  end

  # DELETE /apartments/:id
  def destroy
    apartment = find_apartment
    apartment.destroy
    render json: {}
  end

  private

  def apartment_params
    params.permit(:number)
  end

  def find_apartment
    Apartment.find_by!(id: params[:id])
  end

  def render_invalid_response(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
