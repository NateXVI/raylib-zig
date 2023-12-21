const std = @import("std");
const raylib = @import("raylib");
const world = @import("world.zig");

const Random = std.rand.DefaultPrng;

pub const Pipe = struct {
    x: i32,
    y: i32,
    gap: i32,
    captured: bool,

    pub fn init(x: i32) Pipe {
        return Pipe{
            .x = x,
            .y = world.windowHeight / 2,
            .gap = 180,
            .captured = false,
        };
    }

    pub fn draw(self: Pipe) void {
        const width: i32 = 100;
        const halfWidth: i32 = @divFloor(width, 2);
        const halfGap: i32 = @divFloor(self.gap, 2);
        raylib.DrawRectangle(self.x - halfWidth, 0, width, self.y - halfGap, raylib.WHITE);
        raylib.DrawRectangle(self.x - halfWidth, self.y + halfGap, width, 1000, raylib.WHITE);
        raylib.DrawCircle(self.x, self.y, 10, raylib.WHITE);
    }
};

pub const PipeSpawner = struct {
    spacing: i32,
    speed: f32,
    rng: Random,
    pipes: [5]Pipe,

    pub fn init(spacing: i32, speed: f32) PipeSpawner {
        return PipeSpawner{
            .spacing = spacing,
            .speed = speed,
            .rng = Random.init(@intCast(std.time.milliTimestamp())),
            .pipes = [5]Pipe{
                Pipe.init(800),
                Pipe.init(800 + spacing),
                Pipe.init(800 + spacing * 2),
                Pipe.init(800 + spacing * 3),
                Pipe.init(800 + spacing * 4),
            },
        };
    }

    pub fn update(self: *PipeSpawner) void {
        const offset: i32 = @intFromFloat(self.speed * raylib.GetFrameTime());
        for (&self.pipes) |*pipe| {
            pipe.x -= offset;

            if (pipe.x < -100) {
                var rightMostPosition: i32 = 0;
                for (&self.pipes) |*innerPipe| {
                    if (innerPipe.x > rightMostPosition) {
                        rightMostPosition = innerPipe.x;
                    }
                }
                pipe.x = rightMostPosition + self.spacing;
                pipe.captured = false;
            }
        }
    }

    pub fn draw(self: *PipeSpawner) void {
        for (self.pipes[0..]) |pipe| {
            pipe.draw();
        }
    }
};
