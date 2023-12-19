const std = @import("std");
const raylib = @import("raylib");

var pos = raylib.Vector2i{ .x = 100, .y = 200 };
var vel = raylib.Vector2{ .x = 0, .y = 0 };
const gravity: f32 = 20;
const ground: f32 = 960 - 64;
const jumpV: f32 = -10;

pub fn main() void {
    raylib.SetConfigFlags(raylib.ConfigFlags{ .FLAG_WINDOW_RESIZABLE = false });
    raylib.InitWindow(640, 960, "flappi board");
    raylib.SetTargetFPS(60);

    defer raylib.CloseWindow();

    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();
        defer raylib.EndDrawing();

        raylib.ClearBackground(raylib.BLACK);
        raylib.DrawFPS(10, 10);

        vel.y += gravity * raylib.GetFrameTime();
        pos.x += @intFromFloat(vel.x * raylib.GetFrameTime());
        pos.y += @intFromFloat(vel.y);

        if (raylib.IsKeyPressed(raylib.KeyboardKey.KEY_SPACE)) {
            vel.y = jumpV;
        }
        if (pos.y > ground) {
            pos.y = ground;
            vel.y = 0;
        }
        if (pos.y < 0) {
            pos.y = 0;
        }

        raylib.DrawRectangle(pos.x, pos.y, 64, 64, raylib.YELLOW);
    }
}
