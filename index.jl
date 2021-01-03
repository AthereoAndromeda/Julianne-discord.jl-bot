using Discord
import DotEnv
DotEnv.config()

commandFiles = filter(cmd -> endswith(cmd, ".jl"), readdir("./commands"))
commands = []

for (index, commandFile) in enumerate(commandFiles) 
    command = include("./commands/$commandFile")
    push!(commands, command)
end

println(commands)

@time const C = Discord.Client(ENV["TOKEN"], prefix="$(ENV["PREFIX"]) "; presence=(game=(name=ENV["PREFIX"] * " help", type=AT_LISTENING),))

for (index, command) in enumerate(commands)
    @time add_command!(C, command; precompile = true)
end

open(C)
wait(C)
close(C)