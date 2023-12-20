const std = @import("std");
const raylib = @import("raylib");
const world = @import("world.zig");

pub const Bird = struct {
    pos: raylib.Vector2i,
    vel: raylib.Vector2,
    size: raylib.Vector2i,
    jumpV: f32,

    pub fn new() Bird {
        return Bird{
            .pos = raylib.Vector2i{ .x = 160, .y = 280 },
            .vel = raylib.Vector2{ .x = 0, .y = 0 },
            .size = raylib.Vector2i{ .x = 64, .y = 64 },
            .jumpV = -10,
        };
    }

    pub fn update(self: *Bird) void {
        self.vel.y += world.gravity * raylib.GetFrameTime();
        self.pos.x += @intFromFloat(self.vel.x * raylib.GetFrameTime());
        self.pos.y += @intFromFloat(self.vel.y);

        if (raylib.IsKeyPressed(raylib.KeyboardKey.KEY_SPACE)) {
            self.vel.y = self.jumpV;
        }

        const ground = world.windowHeight - self.size.y;
        if (self.pos.y > ground) {
            self.pos.y = ground;
            self.vel.y = 0;
        }
        if (self.pos.y < 0) {
            self.pos.y = 0;
        }
    }

    pub fn draw(self: *Bird) void {
        raylib.DrawRectangle(self.pos.x, self.pos.y, self.size.x, self.size.y, raylib.YELLOW);
    }
};
