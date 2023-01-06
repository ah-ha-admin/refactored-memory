// inside build.rs

fn main() {
    // The panic is just used to print the information to the console.
    panic!("current build target: {:#?}",
        build_target::target().unwrap()
    );
}
