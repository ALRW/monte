require 'monte/commands/carlo'

RSpec.describe Monte::Commands::Carlo do
  it "executes `carlo` command successfully" do
    output = StringIO.new
    backlog = nil
    throughput = nil
    options = {}
    command = Monte::Commands::Carlo.new(backlog, throughput, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
