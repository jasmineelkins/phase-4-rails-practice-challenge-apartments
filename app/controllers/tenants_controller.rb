class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  # GET /tenants
  def index
    tenants = Tenant.all
    render json: tenants
  end

  # GET /tenants/:id
  def show
    tenant = find_tenant
    render json: tenant
  end

  # POST /tenants
  def create
    new_tenant = Tenant.create!(tenant_params)
    render json: new_tenant, status: :created
  end

  # UPDATE /tenants/:id
  def update
    tenant = find_tenant
    tenant.update!(tenant_params)
    render json: tenant
  end

  # DELETE /tenants/:id
  def destroy
    tenant = find_tenant
    tenant.destroy
    render json: {}
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end

  def find_tenant
    Tenant.find_by!(id: params[:id])
  end

  def render_invalid_response(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
