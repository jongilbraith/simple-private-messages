class <%= plural_camel_case_name %>Controller < ApplicationController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @<%= plural_lower_case_name %> = @<%= singular_lower_case_parent %>.sent_messages
    else
      @<%= plural_lower_case_name %> = @<%= singular_lower_case_parent %>.received_messages
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @<%= singular_lower_case_name %> = <%= singular_camel_case_name %>.read(params[:id], current_<%= singular_lower_case_parent %>)
  end
  
  def new
    @<%= singular_lower_case_name %>_content = <%= singular_camel_case_name %>Content.new
    @<%= singular_lower_case_name %>_content.to = []

    if params[:reply_to]
      @reply_to = current_<%= singular_lower_case_parent %>.received_messages.find(params[:reply_to])
      unless @reply_to.nil?
        @<%= singular_lower_case_name %>_content.to = [@reply_to.sender.id]
        @<%= singular_lower_case_name %>_content.subject = "Re: #{@reply_to.<%= singular_lower_case_name %>_content.subject}"
        @<%= singular_lower_case_name %>_content.body = "\n\n*Original <%= singular_lower_case_name %>*\n\n #{@reply_to.<%= singular_lower_case_name %>_content.body}"
      end
    end
  end
  
  def create    
    @<%= plural_lower_case_parent %> = (<%= singular_camel_case_parent %>.find(params[:<%= singular_lower_case_name %>_content][:to]) if params[:<%= singular_lower_case_name %>_content][:to])
    @<%= singular_lower_case_name %>_content = <%= singular_camel_case_name %>Content.new(params[:<%= singular_lower_case_name %>_content])
    
    respond_to do |format|
      if @<%= singular_lower_case_name %>_content.save
        @<%= plural_lower_case_name %> = []
        for <%= singular_lower_case_parent %> in @<%= plural_lower_case_parent %> do
          <%= singular_lower_case_name %> = <%= singular_camel_case_name %>.new
          <%= singular_lower_case_name %>.sender = current_<%= singular_lower_case_parent %>
          <%= singular_lower_case_name %>.recipient = <%= singular_lower_case_parent %>
          <%= singular_lower_case_name %>.sender_deleted = 1 if params[:<%= singular_lower_case_name %>_content][:no_save] == 'true'
          @<%= plural_lower_case_name %> << <%= singular_lower_case_name %>
        end
        @<%= singular_lower_case_name %>_content.<%= plural_lower_case_name %> = (@<%= plural_lower_case_name %> || [])
        
        format.html { redirect_to(<%= singular_lower_case_parent %>_<%= plural_lower_case_name %>_path(@<%= singular_lower_case_parent %>), :notice => "<%= singular_camel_case_name %> sent") }
        format.xml  { render :xml => @<%= singular_lower_case_name %>_content, :status => :created, :location => @<%= singular_lower_case_name %>_content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= singular_lower_case_name %>_content.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|  
          @<%= singular_lower_case_name %> = <%= singular_camel_case_name %>.where("<%= singular_lower_case_name %>.id = ? AND (sender_id = ? OR recipient_id = ?)", id, current_<%= singular_lower_case_parent %>, current_<%= singular_lower_case_parent %>).first()
          unless @<%= singular_lower_case_name %>.nil?
            counter = <%= singular_camel_case_name %>.where("<%= singular_lower_case_name %>_content_id = ? AND (sender_deleted = 0 OR recipient_deleted = 0)", @<%= singular_lower_case_name %>.<%= singular_lower_case_name %>_content_id).count
            @<%= singular_lower_case_name %>.mark_deleted(current_<%= singular_lower_case_parent %>, counter) unless @<%= singular_lower_case_name %>.nil?
          end
        }
        flash[:notice] = "<%= plural_camel_case_name %> deleted"
      end
      redirect_to user_<%= singular_lower_case_name %>_path(@<%= singular_lower_case_parent %>, @<%= plural_lower_case_name %>)
    end
  end

  
  private
    def set_user
      @<%= singular_lower_case_parent %> = <%= singular_camel_case_parent %>.find(params[:<%= singular_lower_case_parent %>_id])
    end
end