pub fn interspace_chars(text: &str, sep: &str) -> String {
    text.lines() 
    .map(|line| {
        line.chars()  
            .map(|c| c.to_string())  
            .collect::<Vec<String>>()  
            .join(" ")  
    })
    .collect::<Vec<String>>()  
    .join("\n")
}