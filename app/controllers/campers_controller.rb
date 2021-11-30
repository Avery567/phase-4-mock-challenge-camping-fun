class CampersController < ApplicationController

    def index
        campers = Camper.all
        render json: campers, status: 200, include: [:id, :name, :age]
    end

    def show
        camper = Camper.find_by(id: params[:id])
        if camper
            render json: camper, serializer: CamperSerializer
        else
            render json: { error: "Camper not found" }, status: :not_found
        end
    end

    def create
        camper = Camper.create(camper_params)
        if camper.valid?
            render json: camper, status: :created
        else
            render json: { errors: camper.errors.full_messages }, status: :unprocessable_entity, include: [:id, :name, :age]
        end
    end

private

def camper_params
    params.permit(:name, :age)
end

end
