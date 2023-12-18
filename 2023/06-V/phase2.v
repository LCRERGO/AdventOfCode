module main

import os
import strconv

fn solve(lines []string) {
	mut sum := 0
	pre_times := strconv.parse_int(lines[0]
		.split(':')[1]
		.split(' ')
		.filter(it != '')
		.join(''), 0, 64) or { panic(err) }

	pre_distances := strconv.parse_int(lines[1]
		.split(':')[1]
		.split(' ')
		.filter(it != '')
		.join(''), 0, 64) or { panic(err) }

	times := [pre_times]
	distances := [pre_distances]

	// println('t: ${times}')
	// println('d: ${distances}')

	mut prod := 1
	for i in 0 .. times.len {
		sum = 0
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
