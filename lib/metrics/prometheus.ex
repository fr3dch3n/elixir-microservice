defmodule MagellanMicroservice.PipelineInstrumenter do
  @moduledoc false
  use Prometheus.PlugPipelineInstrumenter

  def label_value(:request_path, conn) do
    conn.request_path
  end
end

defmodule MagellanMicroservice.PrometheusExporter do
  @moduledoc false
    use Prometheus.PlugExporter
end