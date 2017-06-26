class StaticPagesController < ApplicationController

  def index

    require 'rubygems'
    require 'nokogiri'
    require 'mechanize'

    if params[:codigo].to_s.empty?
      @codigo = params[:codigo]
    else
      @codigo = params[:codigo].upcase

      agent = Mechanize.new { |agent|
        agent.user_agent_alias = 'Windows Chrome'
      }

      page = agent.get("http://www2.correios.com.br/sistemas/rastreamento/")
      search_form = page.forms.first
      search_form.field_with(:name => "objetos").value = @codigo

      results = agent.submit search_form
      #puts results.body

      html_results = Nokogiri::HTML(results.body)
      @response = html_results.at_css('.highlightSRO strong')

      if @response
        @response = @response.inner_html.encode("UTF-8")
      else
        @response = "Código não encotrado no dados do correio"
      end

      render template: 'static_pages/index.html.erb'
    end

  end

end
