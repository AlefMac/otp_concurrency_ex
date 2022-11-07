defmodule StartObtainingTransferTeste do
  use ExUnit.Case

  alias GenServer.StartObtainingTransfer

  describe "start_link/1" do
    test "accepts a measurement count on start" do
      max_measuruments = 3
      assert {:ok, pid} = StartObtainingTransfer.start_link(max_measuruments)
    end
  end

  describe "schedule_work/0" do
    
  end
end
