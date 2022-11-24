# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = gitlab.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if gitlab.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

## Let's check if there are any changes in the project folder
has_app_changes = !git.modified_files.grep(/TFApp/).empty? || !git.modified_files.grep(/TFPresentation/).empty? || !git.modified_files.grep(/TFDomain/).empty? || !git.modified_files.grep(/TFData/).empty? || !git.modified_files.grep(/TFExtensions/).empty?

## Then, we should check if tests are updated
has_test_changes = !git.modified_files.grep(/UnitTests/).empty?
## Then, we should check if UI tests are updated
has_ui_test_changes = !git.modified_files.grep(/UITests/).empty?

## Finally, let's combine them and put extra condition 
## for changed number of lines of code
if has_app_changes && !(has_test_changes || has_ui_test_changes) && git.lines_of_code > 20
  warn("Tests were not updated", sticky: false)
end

# ** Code Coverage **
#xcov.report(
#   scheme: 'UnitTests',
#   configuration: 'Debug DEV',
#   workspace: 'TFTemplate.xcworkspace',
#   minimum_coverage_percentage: 5.0
#)
 
# ** FILE CHECKS **
# Checks for certain rules and warns if needed.
# Some rules can be disabled by using // danger:disable rule_name
# 
# Rules:
# - Check to see if any of the modified or added files contains a class which isn't indicated as final (final_class)
# - Check for large files without any // MARK: 
# - Check for the usage of unowned self. We rather like to use weak self to be safe.
# - Check for override methods which only implement super calls. These can be removed.
# - Check for public properties or methods which aren't documented (public_docs)

# Sometimes an added file is also counted as modified. We want the files to be checked only once. 
files_to_check = (git.modified_files + git.added_files).uniq
(files_to_check - %w(Dangerfile)).each do |file|
	next unless File.file?(file)
	# Only check for classes inside swift files
	next unless File.extname(file).include?(".swift")
  	
  	# Will be used to check if we're inside a comment block.
	isCommentBlock = false

	# Will be used to track if we've placed any marks inside our class.
	foundMark = false 

	# Collects all disabled rules for this file.
	disabled_rules = []

	filelines = File.readlines(file)
	filelines.each_with_index do |line, index|
		if isCommentBlock
			if line.include?("*/")
				isCommentBlock = false
			end
		elsif line.include?("/*")
			isCommentBlock = true
		elsif line.include?("danger:disable")
			rule_to_disable = line.split.last
			disabled_rules.push(rule_to_disable)
		else
			# Start our custom line checks
			## Check for the usage of final class
			if disabled_rules.include?("final_class") == false and line.include?("class") and not line.include?("final") and not line.include?("func") and not line.include?("//") and not line.include?("protocol")
				warn("Consider using final for this class or use a struct (final_class)", file: file, line: index+1) 
			end

			## Check for the usage of unowned self
			if line.include?("unowned self")
				warn("It's safer to use weak instead of unowned", file: file, line: index+1) 
			end

			## Check for methods that only call the super class' method
			if line.include?("override") and line.include?("func") and filelines[index+1].include?("super") and filelines[index+2].include?("}")
				warn("Override methods which only call super can be removed", file: file, line: index+3) 
			end

			## Check if our line includes a MARK:
			if line.include?("MARK:") and line.include?("//")
				foundMark = true
			end
		end 
	end

	## Check wether our file is larger than 200 lines and doesn't include any Marks
	if filelines.count > 200 and foundMark == false 
		warn("Consider to place some `MARK:` lines for files over 200 lines big.")
	end
end