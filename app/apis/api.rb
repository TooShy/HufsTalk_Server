class API < Grape::API

  before do
    header["Access-Control-Allow-Origin"]   = "*"
    header["Access-Control-Request-Method"] = "*"
    header["Content-type"] = "application/json; charset=utf-8"
  end

  format    :json
  content_type :json, 'application/json; charset=utf-8'

  # Apis
  mount V1::Base

  # Docs
  add_swagger_documentation  base_path: "/api/client",
                             api_version: 'v1',
                             info: {
                               contact: "tokirin1117@gmail.com",
                               description: "훕스톡 클라이언트용 RESTFUL API입니다.",
                               title: "HUFSTALK SERVER RESTFUL API V1"
                             },
                             markdown: false,
                             hide_documentation_path: true,
                             hide_format: true,
                             include_base_url: true,
                             models: ::Entities.constants.select { | c | Class === ::Entities.const_get(c) }.
                                                          map { | c | "::Entities::#{c.to_s}".constantize }
end
