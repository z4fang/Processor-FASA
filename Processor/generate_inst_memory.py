#!/usr/bin/env python3

# Totally optional, here's a neat thing:
# You can create a reverse-mapping, such that waveform tools will show the
# original instruction.
# The waveform viewing tool needs a mapping of # `$value $display_string`.
# Only want to write each unique machine code once though.
# mcodes = set()

# Here's a lookup table for opcodes
ops = {
		'ADD': '00000',
		'XOR': '00001',
		'ORR': '00010',
		'LOD': '00011',
		'STR': '00100',
		'BNE': '00101',
		'SLL': '00110',
		'SRL': '00111',
		'AND': '01000',
		'XXR': '01001',
		'CPP': '01010',
		'CYY': '01011',
		'SUB': '01100',
		'BGT': '01101',
		'LDI': '1',
		}

# This is a neat trick to catch programming errors
TOTAL_IMEM_SIZE = 2**10

# Don't need to do anything fancy here
with open('prog_1.asm') as ifile, open('inst_mem.hex', 'w') as imem:
	for lineno, line in enumerate(ifile):
		try:
			line = line.strip()
			line = line.split('//')[0].strip()
			if line == '':
				continue

			# Special-case this:
			if line[:4] == 'halt':
				machine_code = '111111111'
			else:
				# Every line should be of the form
				# OP	RS RT
				op, rt = line.split()

				print(rt)
				if op != 'LDI':
					rt = '{:04b}'.format(int(rt.split('r')[1]))

				# Build the instruction:
				machine_code = ops[op] + rt

			# Write the imem entry
			imem.write(machine_code + '\n')
			TOTAL_IMEM_SIZE -= 1

			# Write out our waveform decoder
			# if machine_code not in mcodes:
			# 	line = line.replace('\t', ' ')
			# 	wavefmt.write('{} {}\n'.format(machine_code, line))
			# 	mcodes.add(machine_code)
		except:
			print("Error Parsing Line ", lineno)
			print(">>>{}<<<".format(line))
			print()
			raise

	# This is a neat trick to catch programming errors:
	# Fill the rest of instruction memory with illegal instructions.
	#
	# wavefmt.write('xxxxxxxxx ILLEGAL!')
	while TOTAL_IMEM_SIZE:
		imem.write('xxxxxxxxx\n')
		TOTAL_IMEM_SIZE -= 1

