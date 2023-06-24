const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    var libduckdb_module = b.createModule(.{ .source_file = .{ .path = "lib/libduckdb.so" } });

    try b.modules.put(b.dupe("libduckdb"), libduckdb_module);

    const lib = b.addStaticLibrary(.{
        .name = "duckdb",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath("include");
    lib.addLibraryPath("lib");
    lib.linkSystemLibraryName("duckdb");

    lib.installHeader("include/duckdb.h", "duckdb.h");

    // b.installLibFile("lib/libduckdb.so", "libduckdb.so");
    const lib_install_step = b.addInstallLibFile(.{ .path = "lib/libduckdb.so" }, "libduckdb.so");
    b.getInstallStep().dependOn(&lib_install_step.step);

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);
}
