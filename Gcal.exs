defmodule GCalc do
  use GenServer

  def add(x, y) do
    GenServer.call(GCalc.Calculator, {:add, x, y})
  end

  def start_link() do
    GenServer.start_link(GCalc, nil, name: GCalc.Calculator)
  end

  def init(param) do
    IO.puts "Inicio de GenServer GCalc"
    IO.inspect param
    {:ok, %{conteo: 0}}
  end

  def finalizado(reason, state) do
    IO.puts "Finalizado este proceso"
    nil
  end

  def handle_call({:add, n, m}, _from, %{conteo: conteo}) do
    IO.puts "handle_call(:add, #{n}, #{m})"
    resultado = n + m
    {:reply, resultado, %{conteo: conteo + 1}}
  end

  def handle_call({:div, n, m}, _from, state) do
    if m == 0 do
      {:stop, "no es posible dividir por cero", state}
    else
      {:reply, n / m, state}
    end
  end
end

