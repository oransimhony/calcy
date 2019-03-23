defmodule Calcy.Evaluator do
    @moduledoc """
    Documentation for the Evaluator.
    """

    import IO.ANSI

    @doc """
    Returns the value of a addition operation between the left and right hand sides
    """
    def eval(env, {:plus, right, left}) do
        eval(env, right) + eval(env, left)
    end

    @doc """
    Returns the value of a subtraction operation between the left and right hand sides
    """
    def eval(env, {:minus, right, left}) do
        eval(env, right) - eval(env, left)
    end

    @doc """
    Returns the value of a multiplication operation between the left and right hand sides
    """
    def eval(env, {:mult, right, left}) do
        eval(env, right) * eval(env, left)
    end

    @doc """
    Returns the value of a division operation between the left and right hand sides
    """
    def eval(env, {:divi, right, left}) do
        case eval(env, left) do
            0 -> "Cannot divide by zero"
            val -> eval(env, right) / val
        end
    end

    @doc """
    Returns the value of a power operation between the left and right hand sides
    """
    def eval(env, {:pow, right, left}) do
        :math.pow(eval(env, right), eval(env, left))
    end

    @doc """
    Returns the value of the integer
    """
    def eval(_env, {:int, int}) do
        int
    end

    @doc """
    Returns the value of the float
    """
    def eval(_env, {:float, float}) do
        float
    end

    @doc """
    Returns the value of the identifier
    """
    def eval(env, {:ident, name}) do
        lookup(name, env)
    end

    @doc """
    Assigns the value of expr to name and saves it in the environment
    """
    def eval(env, {:assign, name, expr}) do
        val = eval(env, expr)
        IO.inspect name
        if name == :pi, do: raise "Cannot change pi"
        if name == :e, do: raise "Cannot change e"
        {Map.put(env, name, val), val}

    end

    @doc """
    Prints the environment
    """
    def eval(env, {:stack}) do
        Enum.each env, fn {k, v} -> 
            IO.puts blue() <> "#{k}: " <> reset() <> "\t#{v}"
        end
        nil
    end

    @doc """
    Returns an exit atom if the current node is exit
    """
    def eval(_env, {:exit}) do
        :exit
    end

    @doc """
    Looks up the variable in the environment
    Throws an error if the variable is not defined
    """
    def lookup(name, env) do
        case Map.get(env, name) do
            nil -> raise "#{name} has not been declared"
            val -> val
        end
    end
end