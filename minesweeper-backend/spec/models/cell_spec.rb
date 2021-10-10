require 'rails_helper'

RSpec.describe Cell, type: :model do
  subject { Cell.new }

  describe "#to_s" do
    context "when revealed" do
      subject { Cell.new(revealed: true) }

      it "returns mine value when the cell has a mine" do
        subject.mine = true
        expect(subject.to_s).to eq("x")
      end

      it "returns empty value when cell has no mine" do
        subject.mine = false
        expect(subject.to_s).to eq(" ")
      end
    end

    context "when not revealed" do
      subject { Cell.new(revealed: false) }

      it "hides cell value" do
        subject.mine = true
        expect(subject.to_s).to eq("*")
      end

      it "returns flag value when cell is flagged" do
        subject.flagged = true
        expect(subject.to_s).to eq("F")
      end
    end
  end
end
