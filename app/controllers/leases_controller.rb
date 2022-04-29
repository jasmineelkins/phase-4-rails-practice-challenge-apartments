class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  # POST /leases
  def create
    new_lease = Lease.create!(lease_params)
    render json: new_lease, status: :created
  end

  # DELETE /leases/:id
  def destroy
    lease = find_lease
    lease.destroy
    render json: {}
  end

  private

  def lease_params
    params.permit(:rent, :tenant_id, :apartment_id)
  end

  def find_lease
    Lease.find_by!(id: params[:id])
  end

  def render_invalid_response(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
