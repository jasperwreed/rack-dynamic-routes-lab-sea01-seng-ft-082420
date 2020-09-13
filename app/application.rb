require 'rack'
require 'pry'

class Application

    @@item = [Item.new("Figs", 3.42), Item.new("Pears",0.99)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            item = @@item.find{|i| i.name == item_name}
            if @@item.include?(item)
                resp.write item.price
            else
                resp.write "Item not found"
                resp.status = 400
                # binding.pry
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end
end