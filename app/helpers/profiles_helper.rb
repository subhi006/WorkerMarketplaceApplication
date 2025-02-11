module ProfilesHelper
  def download_pdf(myresume)
    client = Client.find(params[:id])
    send_data generate_pdf(client),
              filename: "#{client.name}.pdf",
              type: "application/pdf"
  end
  def status(status)
        if status.work_status.eql?("open")
          "Open to work"
        else
          "Currently working"
        end
  end
  def user_company(profile)
    profile.user.applications.approved.first.task.company
  end
  def user_category(profile)
    profile.user.applications.approved.first.task.category.name
  end
end
