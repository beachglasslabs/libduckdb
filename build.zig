const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    _ = b.addModule("libduckdb.so", .{ .source_file = .{ .path = "lib" } });
    _ = b.addModule("duckdb.h", .{ .source_file = .{ .path = "include" } });
    const lib_install_step = b.addInstallLibFile(.{ .path = "lib/libduckdb.so" }, "libduckdb.so");
    const header_install_step = b.addInstallHeaderFile("include/duckdb.h", "duckdb.h");
    b.getInstallStep().dependOn(&lib_install_step.step);
    b.getInstallStep().dependOn(&header_install_step.step);
}
