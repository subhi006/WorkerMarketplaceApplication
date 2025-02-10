class Contractor::ApplicationsController < ApplicationController
  before_action :authenticate_user!
  after_action :send_approve_mail_sms, only: [ :approve ]
  after_action :send_reject_mail_sms, only: [ :reject ]
  after_action :set_task, only: [ :approve ]

  def show
  end
  def per_task_appliation
    authorize! :read, Application
    if params[:q].present?
        @q = Profile.ransack(params[:q])
        @profile = @q.result
        @applications = Application.where(task_id: params[:task_id]).includes(worker: [ :profile ])
    else
    @q =Application.where(task_id: params[:task_id]).includes(worker: [ :profile ]).ransack(params[:q])
    @applications = @q.result
    end
  end

  def approve
    @application = Application.find(params[:id])
    authorize! :approve, Application
    if @application.update(status: "approved")
     redirect_to contractor_per_task_appliation_path(@application.task), notice: "Application has been approved."
    end
  end


  def reject
    @application = Application.find(params[:id])
    authorize! :reject, Application
    if @application.update(status: "rejected")
       redirect_to contractor_per_task_appliation_path(@application.task),  notice: "Application has been rejected."
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def send_reject_mail_sms
    SendRejectMailSmsJob.perform_later(@application.worker)
  end
  def send_approve_mail_sms
    SendApproveMailSmsJob.perform_later(@application.worker)
  end
  def set_task
    @application.task.number_of_position-=1
    @application.task.save
  end
end
