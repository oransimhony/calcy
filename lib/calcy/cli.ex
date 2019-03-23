defmodule Calcy.CLI do
    @moduledoc """
    Documentation for the CLI.
    """
    import IO.ANSI

    @doc """
    Calls the REPL without minding the arguments
    """
    def main(_args) do
        repl(%{})
    end

    @doc """
    Interactive REPL for calcy
    """
    def repl(env) do
        program = IO.gets green() <> "calcy> " <> reset()
        env = Calcy.run(program, env)
        repl(env)
    end
end