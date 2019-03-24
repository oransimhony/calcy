defmodule Calcy.IR do
    @moduledoc """
    Documentation for the Intermediate Representation.
    """

    @doc """
    Takes an ast and translates it to Intermediate Langauge
    """
    # {:plus, {:int, 123}, {:int, 2}
    # Calcy.IR.ir({:plus, {:int, 123}, {:int, 2}})
    def ir({:plus, left, right}) do
        ir(left) ++ ir(right) ++ [:add]
    end

    def ir({:minus, left, right}) do
        ir(left) ++ ir(right) ++ [:sub]
    end

    def ir({:mult, left, right}) do
        ir(left) ++ ir(right) ++ [:mul]
    end

    def ir({:divi, left, right}) do
        ir(left) ++ ir(right) ++ [:div]
    end

    def ir({:pow, left, right}) do
        ir(left) ++ ir(right) ++ [:pow]
    end

    def ir({:int, num}) do
        [{:push, num}]
    end

    def ir({:float, num}) do
        [{:push, num}]
    end

    def ir({:ident, name}) do
        [{:push, name}] ++ [:lookup]
    end

    def ir({:assign, name, expr}) do
        [{:push, name}] ++ ir(expr) ++ [:assign]
    end

    def ir({:exit}) do
        [:ret]
    end

    def ir({:table}) do
        [:sym]
    end

    def ir(tree) when is_list(tree) do
        ir_sub_trees(tree, [])
    end

    def ir(tree) do
        IO.inspect(tree)
        [:nop]
    end

    def ir_sub_trees([tree | sub_trees], results) do
        result = ir(tree)
        ir_sub_trees(sub_trees, results ++ result)
    end

    def ir_sub_trees([], results) do   
        results
    end
    
end