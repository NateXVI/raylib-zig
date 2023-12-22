const std = @import("std");
const bird_util = @import("bird.zig");
const pipe_util = @import("pipe.zig");
const score_util = @import("score.zig");
const raylib = @import("raylib");

pub const Game = struct {
    bird: bird_util.Bird,
    pipes: pipe_util.PipeSpawner,
    score: i32,

    pub fn init() Game {
        return Game{
            .bird = bird_util.Bird.init(),
            .pipes = pipe_util.PipeSpawner.init(400, 250),
            .score = 0,
        };
    }

    pub fn update(self: *Game) void {
        self.pipes.update();
        self.bird.update();
        score_util.updateScore(self);
    }

    pub fn draw(self: *Game) void {
        self.pipes.draw();
        self.bird.draw();
        score_util.drawScore(self);
        std.debug.print("{p}\n", .{&self});
    }

    pub fn updateScore(self: *Game) void {
        for (&self.pipes.pipes) |*pipe| {
            if (!pipe.captured and pipe.x < self.bird.pos.x) {
                pipe.captured = true;
                self.score += 1;
            }
        }
    }

    pub fn drawScore(self: *Game) void {
        const score = raylib.TextFormat(std.heap.page_allocator, "{}", .{self.score}) catch {
            return;
        };
        raylib.DrawText(
            score,
            10,
            10,
            20,
            raylib.WHITE,
        );
    }
};
