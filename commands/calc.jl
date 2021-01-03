module Calc
    using Discord 
    using Polynomials

    function main(C::Client, m::Message, args::String)
        try
            local op = Meta.parse(args) 
            local res = eval(:(
                a=variable("a");
                b=variable("b");
                c=variable("c");
                d=variable("d");
                e=variable("e");
                f=variable("f");
                g=variable("g");
                h=variable("h");
                i=variable("i");
                k=variable("k");
                l=variable("l");
                m=variable("m");
                n=variable("n");
                o=variable("o");
                p=variable("p");
                q=variable("q");
                r=variable("r");
                s=variable("s");
                t=variable("t");
                u=variable("u");
                v=variable("v");
                w=variable("w");
                x=variable("x"); 
                y=variable("y");
                z=variable("z");
                $op
            ))
    
            reply(C, m, string(res))
        catch (err)
            reply(C, m, "It seems something went wrong. This is only for basic operations.\n`$(string(err))`")
        end
    
    end

    @command(
        name = :calc,
        handler = main,
        help = "Calculates basic stuff",
        pattern = r"^calc (.+)"
    )
end