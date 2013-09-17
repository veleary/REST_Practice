require 'JSON'
require 'rest-client'

# response = RestClient.get('http://makerblog.herokuapp.com/posts', 
#   {:accept => :json})

# puts response
# puts response.code
# puts response.class

# post = JSON.parse(response)
# puts posts.class
# puts posts

module MakerBlog
  class Client
   
   def list_posts
      posts = RestClient.get 'http://makerblog.herokuapp.com/posts', 
        :accept => :json
      posts = JSON.parse(posts)
      posts.each do |post|
        puts post["name"]
        puts post["title"]
        puts post["content"]
      end
    end

  def show_post(id)
  url = 'http://makerblog.herokuapp.com/posts/' + id.to_s
  response = RestClient.get url, :accept => :json
  response = JSON.load(response)
  puts response
    end

  def create_post(name, title, content)
  url = 'http://makerblog.herokuapp.com/posts'
  payload = {:post => {'name' => name, 'title' => title, 'content' => content}}
  response = RestClient.post url, payload.to_json, :content_type => :json,
    :accept => :json
    response = JSON.parse(response)
    puts response
     end

  def edit_post(id, options = {})
  url = 'http://makerblog.herokuapp.com/posts/' + id.to_s
  params = {}
  params[:name] = options[:name] unless options[:name].nil?
  params[:title] = options[:title] unless options[:title].nil?
  params[:content] = options[:content] unless options[:content].nil?
  response = RestClient.put url, {:post => params}.to_json, 
  :content_type => :json, :accept => :json
  response = JSON.parse(response)
    puts response
   end   
 
    def delete_post(id)
    url = 'http://makerblog.herokuapp.com/posts/' + id.to_s
    response = RestClient.delete url, :accept => :json
    puts response.code
    end
  end
end

client = MakerBlog::Client.new
client.list_posts
client.create_post("Wino", "Hello", "New Post")
client.edit_post(116, {:title=>"Bonjour"})
client.delete_post(116)









