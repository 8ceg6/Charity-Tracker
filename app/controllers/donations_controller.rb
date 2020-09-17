class DonationsController < ApplicationController
    before_action :authentication_required, except: :create
    skip_before_action :verify_authenticity_token, only: :create
    
    def index 
        if params[:donor_id]
            @donations = Donor.find(params[:donor_id]).donations
            @donor = Donor.find(params[:donor_id])
        else
            @donations = Donation.all 
        end 
    end 

    def new 
        @donor = Donor.find(params[:donor_id])
        if params[:donor_id] && !Donor.exists?(params[:donor_id]) 
            redirect_to charities_path
        else
            @donation = Donation.new(donor_id: params[:donor_id])
            @donation.build_charity
        end
    end 

    def create 
        @donation = Donation.new(don_params)

        if @donation.valid? && current_user.id == params[:donation][:donor_id].to_i
            @donation.save 
           
            redirect_to donor_donations_path(@donation.donor)
        else   
            redirect_to  new_donor_donation_path(@donation.donor)
        end 
    end 

    def show 
    end 

    private 
    
    def don_params 
        params.require(:donation).permit(:amount, :charity_id, :donor_id,
                            charity_attributes:[:name, :id])
    end 
end
