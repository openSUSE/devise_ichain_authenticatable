require "devise/failure_app"

class ::Devise::IchainFailureApp < ::Devise::FailureApp
  protected

  # TODO: find a better way to do that (or even open an issue for Devise)
  # Add ichain_session as a fallback to session
  def scope_path
    opts  = {}
    route = :"new_#{scope}_session_path"
    alt_route = :"new_#{scope}_ichain_session_path"
    opts[:format] = request_format unless skip_format?

    config = Rails.application.config
    opts[:script_name] = (config.relative_url_root if config.respond_to?(:relative_url_root))

    context = send(Devise.available_router_name)

    if context.respond_to?(route)
      context.send(route, opts)
    elsif context.respond_to?(alt_route)
      context.send(alt_route, opts)
    elsif respond_to?(:root_path)
      root_path(opts)
    else
      "/"
    end
  end
end
