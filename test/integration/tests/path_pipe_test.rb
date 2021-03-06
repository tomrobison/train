# encoding: utf-8

describe "file interface" do
  let(:backend) { get_backend.call }

  describe "pipe / fifo" do
    let(:file) { backend.file("/tmp/pipe") }

    it "exists" do
      _(file.exist?).must_equal(true)
    end

    it "is a pipe" do
      _(file.pipe?).must_equal(true)
    end

    it "has type :pipe" do
      _(file.type).must_equal(:pipe)
    end

    it "has owner name root" do
      _(file.owner).must_equal("root")
    end

    it "has group name" do
      _(file.group).must_equal(Test.root_group(backend.os))
    end

    it "has mode 0644" do
      _(file.mode).must_equal(00644)
    end

    it "checks mode? 0644" do
      _(file.mode?(00644)).must_equal(true)
    end

    it "has no link_path" do
      _(file.link_path).must_be_nil
    end

    it "has a modified time" do
      _(file.mtime).must_be_close_to(Time.now.to_i - Test.mtime / 2, Test.mtime)
    end

    it "has inode size of 0" do
      _(file.size).must_equal(0)
    end

    it "has selinux label handling" do
      res = Test.selinux_label(backend, file.path)
      _(file.selinux_label).must_equal(res)
    end

    it "has no product_version" do
      _(file.product_version).must_be_nil
    end

    it "has no file_version" do
      _(file.file_version).must_be_nil
    end
  end
end
