const raylib = @import("raylib");

pub const windowWidth: i32 = 640;
pub const windowHeight: i32 = 960;

pub const gravity: f32 = 20;

pub fn drawBackground() void {
    raylib.ClearBackground(raylib.BLACK);
}
