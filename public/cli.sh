ruby myapp.rb [-h] [-x] [-e ENVIRONMENT] [-p PORT] [-o HOST] [-s HANDLER]
选项是：

-h # 显示帮助
-p # 设置端口号 (默认是 4567)
-o # 设定主机名 (默认是 0.0.0.0)
-e # 设置环境 (默认是 development)
-s # 声明 rack 服务器/处理器 (默认是 thin)
-x # 打开互斥锁 (默认是 off)
heroku logs --tail -a booktra
bundle exec rackup config.ru -p${PORT:-5000}

Sinatra 中有三种预先定义的环境：”development”、”production” 和 “test”。 
环境可以通过 APP_ENV 环境变量设置。默认值为 “development”。 
在开发环境下，每次请求都会重新加载所有模板， 
特殊的 not_found 和 error 错误处理器会在浏览器中显示 stack trace。 在测试和生产环境下，模板默认会缓存。
可以使用预定义的三种方法： development?、test? 和 production? 来检查当前环境：

request.accept              # ['text/html', '*/*']
request.accept? 'text/xml'  # true
request.preferred_type(t)   # 'text/html'
request.body                # 客户端设定的请求主体（见下文）
request.scheme              # "http"
request.script_name         # "/example"
request.path_info           # "/foo"
request.port                # 80
request.request_method      # "GET"
request.query_string        # ""
request.content_length      # request.body 的长度
request.media_type          # request.body 的媒体类型
request.host                # "example.com"
request.get?                # true (其它动词也具有类似方法)
request.form_data?          # false
request["some_param"]       # some_param 参数的值。[] 是访问 params hash 的捷径
request.referrer            # 客户端的 referrer 或者 '/'
request.user_agent          # 用户代理 (:agent 条件使用该值)
request.cookies             # 浏览器 cookies 哈希
request.xhr?                # 这是否是 ajax 请求？
request.url                 # "http://example.com/example/foo"
request.path                # "/example/foo"
request.ip                  # 客户端 IP 地址
request.secure?             # false （如果是 ssl 则为 true）
request.forwarded?          # true （如果是运行在反向代理之后）
request.env                 # Rack 中使用的未处理的 env hash

可选的设置
absolute_redirects
如果被禁用，Sinatra 会允许使用相对路径重定向。 然而这样的话，Sinatra 就不再遵守 RFC 2616 (HTTP 1.1), 该协议只允许绝对路径重定向。
如果你的应用运行在一个未恰当设置的反向代理之后，你需要启用这个选项。 注意 url 辅助方法仍然会生成绝对 URL，除非你传入false 作为第二参数。
默认禁用。

add_charset
设置 content_type 辅助方法会自动为媒体类型加上字符集信息。 你应该添加而不是覆盖这个选项: settings.add_charset << "application/foobar"

app_file
主应用文件的路径，用来检测项目的根路径， views 和 public 文件夹和内联模板。

bind
绑定的 IP 地址 (默认: 0.0.0.0，开发环境下为 localhost)。 仅对于内置的服务器有用。

default_encoding
默认编码 (默认为 "utf-8")。

dump_errors
在日志中显示错误。

environment
当前环境，默认是 ENV['APP_ENV']， 或者 "development" (如果 ENV['APP_ENV'] 不可用)。

logging
使用 logger。

lock
对每一个请求放置一个锁，只使用进程并发处理请求。
如果你的应用不是线程安全则需启动。默认禁用。

method_override
使用 _method 魔法，以允许在不支持的浏览器中在使用 put/delete 方法提交表单。
port
监听的端口号。只对内置服务器有用。
prefixed_redirects
如果没有使用绝对路径，是否添加 request.script_name 到重定向请求。 如果添加，redirect '/foo' 会和 redirect to('/foo') 相同。 默认禁用。
protection
是否启用网络攻击防护。参见上面的保护部分
public_dir
public_folder 的别名。见下文。
public_folder
public 文件存放的路径。只有启用了静态文件服务（见下文的 static）才会使用。 如果未设置，默认从 app_file 推断。
reload_templates
是否每个请求都重新载入模板。在开发模式下开启。
root
到项目根目录的路径。默认从 app_file 设置推断。
raise_errors
抛出异常（会停止应用）。 当 environment 设置为 "test" 时会默认开启，其它环境下默认禁用。
run
如果启用，Sinatra 会负责 web 服务器的启动。若使用 rackup 或其他方式则不要启用。
running
内置的服务器在运行吗？ 不要修改这个设置！
server
服务器，或用于内置服务器的服务器列表。顺序表明了优先级，默认顺序依赖 Ruby 实现。
sessions
使用 Rack::Session::Cookie，启用基于 cookie 的会话。 查看“使用会话”部分以获得更多信息。
show_exceptions
当有异常发生时，在浏览器中显示一个 stack trace。 当 environment 设置为 "development" 时，默认启用， 否则默认禁用。
也可以设置为 :after_handler， 这会在浏览器中显示 stack trace 之前触发应用级别的错误处理。
static
决定 Sinatra 是否服务静态文件。
当服务器能够自行服务静态文件时，会禁用。
禁用会增强性能。
在经典风格中默认启用，在模块化应用中默认禁用。
static_cache_control
当 Sinatra 提供静态文件服务时，设置此选项为响应添加 Cache-Control 首部。 使用 cache_control 辅助方法。默认禁用。
当设置多个值时使用数组： set :static_cache_control, [:public, :max_age => 300]
threaded
若设置为 true，会告诉 Thin 使用 EventMachine.defer 处理请求。
traps
Sinatra 是否应该处理系统信号。
views
views 文件夹的路径。若未设置则会根据 app_file 推断。
x_cascade
若没有路由匹配，是否设置 X-Cascade 首部。默认为 true。