// Some kind of strange octally linked list
use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug)]
pub struct Cell<T> {
    pub data: T,
    pub up: Option<Rc<RefCell<Cell<T>>>>,
    pub down: Option<Rc<RefCell<Cell<T>>>>,
    pub left: Option<Rc<RefCell<Cell<T>>>>,
    pub right: Option<Rc<RefCell<Cell<T>>>>,
    pub up_left: Option<Rc<RefCell<Cell<T>>>>,
    pub up_right: Option<Rc<RefCell<Cell<T>>>>,
    pub down_left: Option<Rc<RefCell<Cell<T>>>>,
    pub down_right: Option<Rc<RefCell<Cell<T>>>>,
}

impl<T> Cell<T> {
    pub fn new(data: T) -> Self {
        Cell {
            data,
            up: None,
            down: None,
            left: None,
            right: None,
            up_left: None,
            up_right: None,
            down_left: None,
            down_right: None,
        }
    }
}

#[derive(Debug)]
pub struct Grid<T> {
    cells: Vec<Vec<Rc<RefCell<Cell<T>>>>>,
    rows: usize,
    cols: usize,
}

impl<T> Grid<T> {
    pub fn new(rows: usize, cols: usize, init_data: T) -> Self 
    where
        T: Clone,
    {
        let mut cells = Vec::with_capacity(rows);
        for i in 0..rows {
            let mut row = Vec::with_capacity(cols);
            for j in 0..cols {
                let cell = Rc::new(RefCell::new(Cell::new(init_data.clone())));
                row.push(cell);
            }
            cells.push(row);
        }

        // Now set the neighbors for each cell
        for i in 0..rows {
            for j in 0..cols {
                let current_cell = &cells[i][j];
                let mut cell_ref = current_cell.borrow_mut();
                
                // Set neighbors in all directions
                if i > 0 {
                    cell_ref.up = Some(Rc::clone(&cells[i - 1][j]));
                    if j > 0 {
                        cell_ref.up_left = Some(Rc::clone(&cells[i - 1][j - 1]));
                    }
                    if j < cols - 1 {
                        cell_ref.up_right = Some(Rc::clone(&cells[i - 1][j + 1]));
                    }
                }
                if i < rows - 1 {
                    cell_ref.down = Some(Rc::clone(&cells[i + 1][j]));
                    if j > 0 {
                        cell_ref.down_left = Some(Rc::clone(&cells[i + 1][j - 1]));
                    }
                    if j < cols - 1 {
                        cell_ref.down_right = Some(Rc::clone(&cells[i + 1][j + 1]));
                    }
                }
                if j > 0 {
                    cell_ref.left = Some(Rc::clone(&cells[i][j - 1]));
                }
                if j < cols - 1 {
                    cell_ref.right = Some(Rc::clone(&cells[i][j + 1]));
                }
            }
        }

        Grid { cells, rows, cols }
    }

    pub fn get(&self, row: usize, col: usize) -> Option<Rc<RefCell<Cell<T>>>> {
        if row < self.rows && col < self.cols {
            Some(Rc::clone(&self.cells[row][col]))
        } else {
            None
        }
    }

    pub fn set(&self, row: usize, col: usize, value: T) 
    where
        T: Clone,
    {
        if row < self.rows && col < self.cols {
            if let Some(cell) = self.get(row, col) {
                let mut cell_ref = cell.borrow_mut();
                cell_ref.data = value;
            }
        }
    }

    pub fn print(&self)
    where
        T: std::fmt::Debug,  
    {
        for row in &self.cells {
            for cell in row {
                let cell_ref = cell.borrow();
                print!("{:?}", cell_ref.data);
            }
            println!();  
        }
    }


    fn find(&self, value: T) -> Option<Rc<RefCell<Cell<T>>>> 
    where
        T: std::cmp::PartialEq,
    {
        for i in 0..self.rows {
            for j in 0..self.cols {
                if let Some(cell) = self.get(i, j) {
                    let cell_ref = cell.borrow();
                    if cell_ref.data == value {
                        return Some(Rc::clone(&cell));
                    }
                }
            }
        }
        None // Return None if the value is not found
    }
}

