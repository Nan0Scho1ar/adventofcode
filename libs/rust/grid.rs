use std::str::FromStr;
use std::fmt::Display;

#[derive(Debug)]
pub struct Grid<T> {
    pub grid: Vec<T>,
    pub rows: usize,
    pub cols: usize,
    pub x: usize,
    pub y: usize,
    pub facing: Direction
}

#[derive(Debug, Clone, PartialEq, Copy, Eq, Hash)]
pub enum Direction {
    Up,
    Down,
    Left,
    Right,
    UpLeft,
    UpRight,
    DownLeft,
    DownRight,
}

impl<T: Clone + Default + FromStr> Grid<T> {
    // Initialize a grid with given dimensions
    pub fn new(rows: usize, cols: usize, x: usize, y:usize, facing: Direction) -> Self {
        let grid = vec![T::default(); rows * cols];
        Grid { grid, rows, cols, x, y, facing }
    }

    // Parse a text grid and convert it into a Grid<T>
    pub fn parse(data: &str) -> Result<Self, String>
    {
        // Split the input string into lines
        let lines: Vec<&str> = data.lines().collect();

        // Determine the number of rows and columns
        let rows = lines.len();
        let cols = lines.get(0).map_or(0, |line| line.split_whitespace().count());

        // Initialize the grid vector
        let mut grid = Vec::with_capacity(rows * cols);

        // Parse each line and fill the grid
        for line in lines {
            let tokens: Vec<T> = line
                .split_whitespace() // Split by whitespace
                .filter_map(|s| s.parse().ok()) // Parse each token into T
                .collect();

            if tokens.len() != cols {
                return Err(format!(
                    "Row has incorrect number of columns. Expected {}, found {}",
                    cols, tokens.len()
                ));
            }

            grid.extend(tokens);
        }

        // Check if the grid has the correct number of elements
        if grid.len() != rows * cols {
            return Err(format!(
                "Grid has incorrect number of elements. Expected {}, found {}",
                rows * cols,
                grid.len()
            ));
        }

        Ok(Grid {
            grid,
            rows,
            cols,
            x: 0,
            y: 0,
            facing: Direction::Up
        })
    }

    // Convert 2D (x, y) to a 1D index
    fn to_index(&self, x: usize, y: usize) -> usize {
        x * self.cols + y
    }

    // Convert 1D index back to 2D (x, y)
    fn to_coordinates(&self, index: usize) -> (usize, usize) {
        (index / self.cols, index % self.cols)
    }

    // Check if a position is within bounds of the grid
    fn is_valid(&self, x: isize, y: isize) -> bool {
        x >= 0 && x < self.rows as isize && y >= 0 && y < self.cols as isize
    }

    // Get the value at current position
    pub fn get_current(&self) -> T {
        let idx = self.to_index(self.x, self.y);
        self.grid[idx].clone()
    }

    // Set the value at current position
    pub fn set_current(&mut self, value: T) -> () {
        let idx = self.to_index(self.x, self.y);
        self.grid[idx] = value;
    }

    // Set the current position
    pub fn set_pos(&mut self, x: usize, y: usize) -> bool {
        if self.is_valid(x as isize, y as isize) {
            self.x = x;
            self.y = y;
            true
        } else {
            false
        }
    }

    // Get the current position
    pub fn get_pos(&self) -> (usize, usize) {
        (self.x, self.y)
    }

    // Set the value at the specified coordinate
    pub fn set_value(&mut self, x: usize, y: usize, value: T) -> bool {
        if self.is_valid(x as isize, y as isize) {
            let idx = self.to_index(x, y);
            self.grid[idx] = value;
            true
        } else {
            false
        }
    }

    // Get the value at the specified coordinate
    pub fn get_value(&self, x: usize, y: usize) -> Option<T> {
        if self.is_valid(x as isize, y as isize) {
            Some(self.grid[self.to_index(x, y)].clone())
        } else {
            None
        }
    }

    pub fn foward(&mut self) -> Option<T> {
        if let Some(result) = self.traverse(self.facing.clone()) {
            Some(result)
        } else {
            None
        }
    }

    // Turns self.facing clockwise in increments of 45deg
    pub fn turn(&mut self, angle: isize) {
        let directions = [
            Direction::Up,
            Direction::UpRight,
            Direction::Right,
            Direction::DownRight,
            Direction::Down,
            Direction::DownLeft,
            Direction::Left,
            Direction::UpLeft,
        ]; 

        // Find the current index of the turtle's direction
        let mut current_index = directions.iter().position(|&d| d == self.facing).unwrap();

        // Calculate the new index based on the angle (in 45-degree increments)
        let steps = angle / 45;  // Angle is in multiples of 45 degrees
        current_index = (current_index as isize + steps).rem_euclid(directions.len() as isize) as usize;

        // Update the facing direction of the turtle
        self.facing = directions[current_index];
    }

    pub fn backward(&mut self) -> Option<T> {
        self.turn(180);
        let result = self.foward();
        self.turn(180);
        result
    }

    pub fn set_facing(&mut self, direction: Direction) -> () {
        self.facing = direction;
    }

    // Traverse the grid in a specified direction and return the new value
    pub fn traverse(&mut self, direction: Direction) -> Option<T> {
        let (dx, dy) = match direction {
            Direction::Up => (-1, 0),
            Direction::Down => (1, 0),
            Direction::Left => (0, -1),
            Direction::Right => (0, 1),
            Direction::UpLeft => (-1, -1),
            Direction::UpRight => (-1, 1),
            Direction::DownLeft => (1, -1),
            Direction::DownRight => (1, 1),
        };

        let new_x = self.x as isize + dx;
        let new_y = self.y as isize + dy;

        if self.is_valid(new_x, new_y) {
            self.x = new_x as usize;
            self.y = new_y as usize;
            self.facing = direction;
            let index = self.to_index(new_x as usize, new_y as usize);
            Some(self.grid[index].clone())
        } else {
            None
        }
    }

    //Get the specified row
    pub fn get_row(&self, row: usize) -> Option<Vec<T>> {
        if row < self.rows {
            let start_idx = row * self.cols;
            let end_idx = start_idx + self.cols;
            let row_data = self.grid[start_idx..end_idx].to_vec();
            Some(row_data)
        } else {
            None
        }
    }

    //Get the specified column
    pub fn get_column(&self, col: usize) -> Option<Vec<T>> {
        if col < self.cols {
            let mut column_data = Vec::with_capacity(self.rows);
            for row in 0..self.rows {
                column_data.push(self.grid[row * self.cols + col].clone());
            }
            Some(column_data)
        } else {
            None
        }
    }

    // Find the first occurance of a value and return it's index
    pub fn find(&self, value: T) -> Option<(usize, usize)>
    where
        T: std::cmp::PartialEq,
    {
        for i in 0..self.grid.len() {
            if self.grid[i] == value {
                return Some(self.to_coordinates(i))
            }
        }
        None
    }


    pub fn print(&self, pos_char: Option<char>)
    where
        T: Display
    {
        for row in 0..self.rows {
            for col in 0..self.cols {
                let index = self.to_index(row, col);
                if row == self.x && col == self.y {
                    if let Some(c) = pos_char {
                        print!("{}", c);
                        continue;
                    } 
                }
                print!("{}", self.grid[index]);
            }
            println!();  
        }
        println!();  
    }

}

