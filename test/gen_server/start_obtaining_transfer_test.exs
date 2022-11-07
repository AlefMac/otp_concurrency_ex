defmodule StartObtainingTransferTest do
  use ExUnit.Case, async: true

  alias GenServer.StartObtainingTransfer

  setup do
    {:ok, pid} = StartObtainingTransfer.start_link()
    %{pid: pid}
  end

  describe "schedule_work/0" do
    test "start service to work" do
     assert :ok = StartObtainingTransfer.schedule_work
    end
  end

  describe "get_info_pid/1" do
    test "fetch pid info", %{pid: pid} do
      infos = StartObtainingTransfer.get_info_pid(pid)
      pid = Keyword.get(infos, :links, "")
      assert pid == pid
    end
  end
end
