RSpec.describe "`monte carlo` command", type: :cli do
  it "executes `monte help carlo` command successfully" do
    output = `monte help carlo`
    expected_output = <<-OUT
Usage:
  monte carlo BACKLOG THROUGHPUT

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
