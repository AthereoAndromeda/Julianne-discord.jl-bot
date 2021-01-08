println("Compiling Modules...")
using Discord
import DotEnv
import TOML
DotEnv.config()

config = TOML.parsefile("./config.toml")
commandFiles = filter(cmd -> endswith(cmd, ".jl"), readdir("./commands"))
commands = []

const PREFIX = config["prefix"]

for (index, commandFile) in enumerate(commandFiles) 
    command = include("./commands/$commandFile")
    push!(commands, command)
end

println("Initializing Client...")
const C = Discord.Client(ENV["TOKEN"], prefix=PREFIX; presence=(game=(name=PREFIX * "help", type=AT_LISTENING),))

for (index, command) in enumerate(commands)
    add_command!(C, command; precompile = true)
end

open(C)
wait(C)
close(C)