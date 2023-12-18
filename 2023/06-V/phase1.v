module main

import os

fn solve(lines []string) {
	times := lines[0]
		.split(':')[1]
		.split(' ')
		.filter(it != '')
		.map(fn (n string) int {
			return n.int()
		})
	distances := lines[1]
		.split(':')[1]
		.split(' ')
		.filter(it != '')
		.map(fn (n string) int {
			return n.int()
		})

	// println('t: ${times}')
	// println('d: ${distances}')

	mut prod := 1
	for i in 0 .. times.len {
		mut sum := 0
		for j in 1 .. times[i] {
			if (distances[i] / j) < (times[i] - j) {
				sum += 1
			}
		}
		println('(sum,prod): (${sum},${prod})')
		prod *= sum
		// println(times[i])
		// println(distances[i])
	}
	println(prod)
}

fn main() {
	if os.args.len < 2 {
		println('Usage: ${os.args[0]} filename')
		exit(1)
	}

	lines := os.read_lines(os.args[1]) or { panic(err) }
	solve(lines)
}
