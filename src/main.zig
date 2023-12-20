const std = @import("std");
const raylib = @import("raylib");
const world = @import("world.zig");
const bird_util = @import("bird.zig");

var pos = raylib.Vector2i{ .x = 100, .y = 200 };
var vel = raylib.Vector2{ .x = 0, .y = 0 };
const ground: f32 = 960 - 64;
const jumpV: f32 = -10;

var bird = bird_util.Bird.new();

pub fn main() void {
    raylib.SetConfigFlags(raylib.ConfigFlags{ .FLAG_WINDOW_RESIZABLE = false });
    raylib.InitWindow(world.windowWidth, 960, "flappi board");
    raylib.SetTargetFPS(60);

    defer raylib.CloseWindow();

    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();
        defer raylib.EndDrawing();

        world.drawBackground();
        raylib.DrawFPS(10, 10);

        bird.update();

        bird.draw();
    }

    std.debug.print("Exiting...\n", .{});
}
