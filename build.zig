const std = @import("std");

pub fn build(b: *std.Build) !void {
    _ = b.addModule("libduckdb.library", .{ .source_file = .{ .path = b.pathFromRoot("lib") } });
    _ = b.addModule("libduckdb.include", .{ .source_file = .{ .path = b.pathFromRoot("include") } });
    _ = b.addModule("libduckdb.h", .{ .source_file = .{ .path = b.pathFromRoot("include/duckdb.h") } });
    _ = b.addModule("libduckdb.a", .{ .source_file = .{ .path = b.pathFromRoot("lib/libduckdb_static.a") } });
    // const lib_install_step = b.addInstallLibFile(.{ .path = "lib/libduckdb.so" }, "libduckdb.so");
    // const header_install_step = b.addInstallHeaderFile("include/duckdb.h", "duckdb.h");
    // b.getInstallStep().dependOn(&lib_install_step.step);
    // b.getInstallStep().dependOn(&header_install_step.step);
}
